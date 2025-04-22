Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC5C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 12:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1766A10E58C;
	Tue, 22 Apr 2025 12:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pu4egLmv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A613710E58C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 12:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHpAyK4WyBk0rauKdCPA6pQqWUJukLxPyn40OcwDbKdBclzEqWeB/sN1VtH3mTTE69nE+JZk7ykNq9HYYWWlXQM2viYSdNVNj/b+/v9ODANK/UajfPuRGzSub/1dvncbkzFZ1+uglqT6pLb+5ewxlG8iKne7ExiwoHayzfzybefilWbSZXy/feBaiKGgEs0Ok1vdytSKkD0xDsWKVMamFllCIngeDBHVBH1PFuxBxOtI6cFBamqrY6yhtB9pFeXsSBPgAhdBoONfS0l75sDUzCYCFIKrMvPFJoi80f6tgwtBEcLWdN084BA2OZKb+DaMnfBDKu7XY0dDLiNEOnQDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thaMaZPqibjUA5szPk1fDlIfkYRqjctdpTpJ0H7utao=;
 b=gVSb2lagiJrIxKaD5SMAwg4jOBSkb470QtqUDCYZMR5XzMzgx2E3fkjLH9uA4UD5RWW98qtQXlf4MjNKnjO1s7kakCkqMBOWMkoLf8JpSgPwSb0HwEBhk/IYwfUv1NBGJZUUG8uT2GmlJSYTiZFBvqvG0ci2SIpl/89XWvHLi138xEq5pirMHh+y/MI30bZPEqnbR3gLKTgIeVZhXVqZMPbnC3pfZxioHKoTXmJz9rgUWhxpbHfASlt0suHoVwGaU28vwfPe2gaKNdYx3RlhHMlmj9JXQZXlcSfGbssJlMZHyXnPml/1wQL6KeSw4Gimmk00VLD34hTxgdbUlBfFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thaMaZPqibjUA5szPk1fDlIfkYRqjctdpTpJ0H7utao=;
 b=Pu4egLmvbFfavJwQgJnl9bMh5VcPrqhbnp/YK0PQed+oV1NczqhAHuQGggxO7X1VdwbGzXo52cNPFITZWu6E8B7JdR/BmcigNq7lsHr9MVcYEqAqwbC4HW17HfhJCcteswV+i3hsdlksuk3W1rJQpJUIkT8BhN5L4419y/ORO2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 12:39:54 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 12:39:53 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
 <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
 <DS7PR12MB6005329D20C8DE2367BDEC8EFBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <95986ce1-558c-4233-a769-bd08d2478538@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <dc72b56f-64a0-ff58-8d4a-4a8fbc870100@amd.com>
Date: Tue, 22 Apr 2025 18:09:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <95986ce1-558c-4233-a769-bd08d2478538@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::7) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fdcfc5-21e7-4c27-40f9-08dd819ac7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUYwUlBaMS9Gc0FEOGpjVTE1WjcvM0hUWC9QN0Q4RmlnTXVuZjYzYnpxMjFv?=
 =?utf-8?B?emIvTE0wWElxcHZEdW5VV1h5K3NyczZRckF6dlJxNmZlL1NBOUI1ditucnU5?=
 =?utf-8?B?VUc2RFdqdFltenBLSW0wdzMrYzlhOWQxaVU2cHNEOGZmc2FEQXpzenBBYUpa?=
 =?utf-8?B?bE1kKyt2QTREK2dNbkhZRExlSTNoejEwdHZMWlp0SGo5ZnMzVTRKSXNzQW1U?=
 =?utf-8?B?VFl1TkM2V1pBNXcxV3NUZmwvOTVYUzZtellrbG5RNTd3d0hpc1JMbHJZd1dE?=
 =?utf-8?B?aFZRRU55QlNkd1JKakkrc2xJT2xiMTlEUmttVE8xNTczUGJ0cnBaN0t5UUNO?=
 =?utf-8?B?RDhwc0FWUWhSZ2I5REViNUtVTlBPMjB0QmJ4T1ZMamY0d01WcUlkZEZsOU9Y?=
 =?utf-8?B?V0lKQXlRMkdxZVU2Z2xEbHBxdk1wS0RmNWV3RytIUzVQbTJoZEkvMTREVGsy?=
 =?utf-8?B?SmNsRlZmQk5mbmxkdnRpRmFkSlN4a2dhTGpOdFZ1eTZYSjk5c1RNK3hZU2VW?=
 =?utf-8?B?RG16SG1Vd1BtQ0Zqa3VLSmgxVEdpUDVWWDlZbTk4d0J2NzR4Qk5qZFJ0TjdF?=
 =?utf-8?B?V2RkYVRNVVBwQUdIclVLYnRNRWRvNWdzN1A1Z3JsSGJCZVZVR2J3aHRxV21T?=
 =?utf-8?B?cU14OE1od014YnhTajMzbTd2NDh2WG1WaVlvVnNzZDM1b1NoQVBhUVJnRlg5?=
 =?utf-8?B?VXRyNmpIZnlXeUE2WndjSW5yVnpBejAvc1dSakdrSmJ2dlZJenZwV3p0MFN0?=
 =?utf-8?B?MWdmcTlBa2paWXd0OUNJUkNmQWYyMDVhZ1FvaERPWitFTWgyVlVNSGw1dTl2?=
 =?utf-8?B?YUEzNnE3YzJtNG85MlUzaVRlM2JLaW1uV2Vma3JwUW9YWHVKSVBwS1l2bk1M?=
 =?utf-8?B?RkRmVC9YeUszUXpiWVhDVFU2WEQxSjRaNTRLYnphTWRtbDhmTlZvb1NUYUVm?=
 =?utf-8?B?ajFHOVcwVE56YjQ5VXgwWUt3bXdXZHpYTFVySyt5bHRjdEJORitZcnl2WFgw?=
 =?utf-8?B?RjdRUURIVXM3T092UDRocmQvWW1aeUQrSHhaS0JBZGdxU2hQd0h6YmpObFFX?=
 =?utf-8?B?WWl2WVlISGM0L1FENUljQzdWS2x3WUk0OEd6VzdCY2ZrQ3dWVmsvMVV5RHdx?=
 =?utf-8?B?OUFCZE94U0lEZEVBVUZTVUZLeXdIbjRmdUJ2M3I0dVZ3RWkxcHhHOHNTMzZh?=
 =?utf-8?B?eVY2NUd2Nm4vSHB6ejArd1A1cW1ycyswRWV6TDNSNTZHYlI2MXlTOE5yaXZD?=
 =?utf-8?B?OUp6SnoyZlJyRmpmd0JrdDZzZGc2SFI5R092ZzVpVkJNSzZjN0NuNWoyc3Y4?=
 =?utf-8?B?VGxoTXFDc0FlbFZxWnVWOEZJQ3dEQ1ZPelZiMmZyT0p1b3NtaStsNG10UTRV?=
 =?utf-8?B?S1IzNHRkM2tkSlBjV0IvckRINzZxbkorbXN5bFRTUVlSWUYzakFQMlhRRUw1?=
 =?utf-8?B?TmtFQ1JoWW5kT09DUkxKTzV2YWU5NHd1OVBuRWtXVDVvM3BnNFVReWFxcE1I?=
 =?utf-8?B?MjN6LzZhaHlXUmdYcUVRbFEzRkJ5M0FYYUNhZGcrWTQ2R3BQNW1uaTBGOFk4?=
 =?utf-8?B?ZVRmY1hxSTU0bUtZejg4eDdYUDFjOThpeEZhRTQvcEtHSFdaR1FvNG1NcHRr?=
 =?utf-8?B?bFV5ZUgyaW9NajkrQmVGeEZKSm1YcXdvZnlBcVpPREEwaHloeVhybFVmcG9q?=
 =?utf-8?B?TENuZDVvR0VkcFdpR1BIZkxrdzM3clVybGkrUm5BckRVaUdka1VLOGh1UWEy?=
 =?utf-8?B?M09zWnQ2bDlRTHQwOTdrZHdUSGtHUWlwWm9GdkkwYk1zMXY1UWlkV2R1ODlU?=
 =?utf-8?B?S0pQdHE2WlkvWi95c1VubkhCTFlpTmgzYU0rWVRMZVJhY0RQYmM1eHJ2MWxI?=
 =?utf-8?B?R3FMQWNGSTJXbGV4UC9aZllHTGlReFN3TWtOYzBuK0NxakZhbFVqRytUV0dX?=
 =?utf-8?Q?cFtY6dseUzs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZHTFlTaHdEYzlOMGpHZ3l1cFl2V0RmZEJHK2FWTHhDYmZWdHFrVy9TM3gw?=
 =?utf-8?B?TVUreUYxdCtnY253WThtd2ViR01XSGdzUU0wcW5Vck5xeVByYjFqN0pjZm5w?=
 =?utf-8?B?Q1ROVytpck5vN1pLTDJKSEVKeDhnUUV2aTdES3RFaWVYanVCdGdadzFjTVF4?=
 =?utf-8?B?eFplTVFMdUV0djJKeGZwNDRLVml3aHVOTmFUcG4vcXp2c0VDaEgyUlBPUDVs?=
 =?utf-8?B?OGo3NGdScCtMZE5WNTVMY0x2M0pYamJ1UTd5elMvVzZWQ1YzcUpLbFZFT3Vs?=
 =?utf-8?B?NURjdVV3OEtqczNZNlJ3Z0NhbjNQdmRmcngzdDc3Y1pBSmc5dHlib2x5RWZw?=
 =?utf-8?B?dU1jcUhlRlN2TlIyeE9JT3IxS3hSWEVTUW5ZcHlrUFZWNWNROXhKTG0wZEFk?=
 =?utf-8?B?RmtXNkJvTTNNZE1Ba1ErYnFCL1dIdloxdFRyM1hVVVlQQ1FYN2V1NVBqZHNS?=
 =?utf-8?B?UlpGL2ZKSmlpNjNaQjVxa2hWSlhrQXBqZE42MEZQWE5tNm5SRnJjVlgzZUE5?=
 =?utf-8?B?dTY1SGtiRmw0d2F0TDZFUnBkWTduYjBydCtVa1hQUEVBaVNJK2ZnY1o2UHR5?=
 =?utf-8?B?TWE4VS9icUpOUmpzbWY0aGkzUEJIakkwdFpxbjl3dnRtWUUxVCt3aWttN1lv?=
 =?utf-8?B?eFZKZzlmOVBvQnFYNzJwc3RzaTl3eUVGU2FqdHNSNU5zNFFFb1lJRDhieTBK?=
 =?utf-8?B?NjlEZks3R1c3a1pqVmlaOUZsTzVyZGZEdWFZb3lIUnZHTDhENGdJdFJtR2g1?=
 =?utf-8?B?cHlTaC83SjhudnZJN3pJM0FyWXhxc1RKSmxEU3ZRMEwyU0dDU3crZlR4K0RN?=
 =?utf-8?B?clU0MXJRTytCby8vS1BkUW9oNUVGK3pPNmYwSjAwUGhKbVk5WTJVdURseXVW?=
 =?utf-8?B?L3ZpR3BaK1RTVU4ycndzTDIyYmxXeEdXUmxFcEd5M1BtSXVwWVZkQlNzNHBK?=
 =?utf-8?B?eWRHZXZ5UTlwQWdVTnhRdk56T1lqSTdOSkZyc2ZVOHUvbDRMK2dzdmFDNEto?=
 =?utf-8?B?UkdyTlpNbnpYU255YzJzYzZzOHdabEZSZmRzcnB5UldEZTd5blc5V1l5TFlL?=
 =?utf-8?B?eTlPVDdIMjVqVURGMHhpem5qcDZLUDRJejY3aytRK1VIVTBwTG1DRGo2ajNI?=
 =?utf-8?B?SnRTb0ZRRHlDVTljeHRVeTJ3bEtaWFYvZGVJVDR5clplTnQ5eC9ubGszMi9K?=
 =?utf-8?B?aXVlK3NaTlEyUmcrL3J2QklFSzBnckEzYzFEbFhlYUJNSTN3cGxvUHBUcC83?=
 =?utf-8?B?VzJxUDQ4ckxhM21aRlRhMWhkamIvT1JISzdZL1k3RVA1YS9WbTFsa1R4anZ5?=
 =?utf-8?B?VHEyeVppYm1TcEp0US9PY3JwS3ZOK1ZDc3Y1MWtVSTYwMVR3TFhSTFNZZkJH?=
 =?utf-8?B?ZC81eUpVKzFvditsU2lsWWlTZWtGaG9VbmdqK3dlamY4b3l5Q3BNYzJxWkhY?=
 =?utf-8?B?YXpwdDNTajFTYXZrWEtPQXhmQzBOemUwNUw3ZHpLSCtVL2tzL29IMmo4cGtS?=
 =?utf-8?B?cFBRelcrdHhMUjVxRmpLcFNpcktOMDZtcG50ZGdsQ1MwSWozVWJVOWNxaDVV?=
 =?utf-8?B?b3NzeFo4VS9DdWJzbmJoTHNFVFBuZlhiUXMxTFZncUozT0RyLzdDYW5odC9m?=
 =?utf-8?B?VThqczZLL2QwRHRBazdZTWF2czZwMlVHVHlWWmxnRTRQQlZFQXlPZEdBL1NT?=
 =?utf-8?B?YkU2UWc3OC9TYUR4VGVsOXlPeGxJZFRoMXRKTlhRT3RDSnI2U1Y2U3JBQjlZ?=
 =?utf-8?B?Y2V4dHIxd1J2Q3RSd1hoaGpaZ1ZYd1NQOU9oa0t2Z3NXRG1wOFdkMmxQK2Nk?=
 =?utf-8?B?WXFmTE43QzRraDArbWlRaXVzSkZ5SjZBWExESGhCTThsZHF6NXNIRUsyd3BB?=
 =?utf-8?B?YzRtRmtJS21YdGgvRHdIU2FwTEJCSS8wNWZEQ040WE9XaUpLMmlaVkFtcDVL?=
 =?utf-8?B?Qm82K245TzJvRmorWVRncnc2aGpiaGxEa0ZtVG8xRXRzbVp4VlQwcTlxbjJr?=
 =?utf-8?B?V3ZlRi9pVmtBYVBqSFJjVE12QmM3MUZEV0dQdk1LazdVL1cxcTlDTitDOWhB?=
 =?utf-8?B?ekxpZVpDNllhU3I3TWFaNkpLQmVmdUhOaEYvNVduZUZ1MXE1M3JtTnVNTkVT?=
 =?utf-8?Q?qx1tF23GKCzFESNW+eps2sSPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fdcfc5-21e7-4c27-40f9-08dd819ac7f3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:39:53.7342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuDW6WdX6kziRL4xOKbW4CoW++BpyKBuWDR//1teHsjhvZcutnxh/ixjcsoxBtaJW78macrVKvyPNmkj6du1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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


On 4/22/2025 2:57 PM, Christian König wrote:
> Am 22.04.25 um 11:14 schrieb Liang, Prike:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Thursday, April 17, 2025 3:40 PM
>>> To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
>>>
>>> Am 16.04.25 um 16:47 schrieb Liang, Prike:
>>>> [Public]
>>>>
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Wednesday, April 16, 2025 7:07 PM
>>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached
>>>>> bo release
>>>>>
>>>>> Am 16.04.25 um 10:50 schrieb Prike Liang:
>>>>>> Free the evf when the attached bo released. The evf still be
>>>>>> dependent on and referred to by the attached bo that is scheduled by
>>>>>> the kernel queue SDMA or gfx after the evf signalled.
>>>>>>
>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>> ---
>>>>>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 31 ++++++++++++++++--
>>> -
>>>>>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  1 +
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>>>>>>   3 files changed, 28 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>>> index b34225bbd85d..60be1ac5047d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>
>>>>>>   #define work_to_evf_mgr(w, name) container_of(w, struct
>>>>>> amdgpu_eviction_fence_mgr, name)  #define evf_mgr_to_fpriv(e)
>>>>>> container_of(e, struct amdgpu_fpriv, evf_mgr)
>>>>>> +#define fence_to_evf(f)  container_of(f, struct
>>>>>> +amdgpu_eviction_fence, base)
>>>>>>
>>>>>>   static const char *
>>>>>>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence) @@
>>>>>> -47,7 +48,7 @@ int  amdgpu_eviction_fence_replace_fence(struct
>>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>>                                  struct drm_exec *exec)  {
>>>>>> -   struct amdgpu_eviction_fence *old_ef, *new_ef;
>>>>>> +   struct amdgpu_eviction_fence *new_ef;
>>>>>>      struct drm_gem_object *obj;
>>>>>>      unsigned long index;
>>>>>>      int ret;
>>>>>> @@ -72,7 +73,6 @@ amdgpu_eviction_fence_replace_fence(struct
>>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>>
>>>>>>      /* Update the eviction fence now */
>>>>>>      spin_lock(&evf_mgr->ev_fence_lock);
>>>>>> -   old_ef = evf_mgr->ev_fence;
>>>>>>      evf_mgr->ev_fence = new_ef;
>>>>>>      spin_unlock(&evf_mgr->ev_fence_lock);
>>>>>>
>>>>>> @@ -102,9 +102,6 @@ amdgpu_eviction_fence_replace_fence(struct
>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>>              }
>>>>>>      }
>>>>>>
>>>>>> -   /* Free old fence */
>>>>>> -   if (old_ef)
>>>>>> -           dma_fence_put(&old_ef->base);
>>>>> That change looks completely incorrect to me, you will now leak the old fence.
>>>> The eviction fence is attached and shared by all the restored validated VM BOs
>>> during UQ restore, and at this placement the eviction fence is only detached from
>>> one of the BOs. Using amdgpu_userq_remove_all_eviction_fences() will walk over
>>> the resv objects and detach the fence from the resv objs when freeing the BO.
>>>
>>> Yeah, but that doesn't justify this change here. See you're completely messing up
>>> the fence reference count with that.
>>>
>>>> But there's a problem: even though dropping all the evf attached to VM BOs with
>>> this patch, the evf still referred to by the SDMA and GFX kernel queue jobs at the
>>> case when enabling the kq and uq at the same time. Thoughts?
>>>
>>> Mhm, the eviction fence is always added as bookmark isn't it? As long as the GFX
>>> and SDMA jobs are not for evicting something then they should only depend on
>>> fences with usage < bookmark.
>>>
>>> Can you dig up when they are added to the dependencies of the job?
>> When the eviction fence was added to the user queue VM BOs reservation and then updated the BO page table, which will add the eviction fence to the VM sync at amdgpu_sync_resv()
> Stop, wait a second. That shouldn't happen at the first place. Why is the eviction fence considered a dependency for page table updates?
>
> When it is added only as bookkeep then we should never consider that here. Looks like something in the sync obj is messed up.
It is like this. Here, amdgpu_sync_resv is using DMA_RESV_USAGE_BOOKKEEP.

         int amdgpu_sync_resv() {

                 ..

                 /* TODO: Use DMA_RESV_USAGE_READ here */
                 dma_resv_for_each_fence(&cursor, resv, 
DMA_RESV_USAGE_BOOKKEEP, f) {
                     dma_fence_chain_for_each(f, f) {

                 ..

}
during PT update amdgpu_vm_bo_update() is using sync to moving 
fences(Eviction fence) before mapping anything. Because of this Eviction 
fence will act as dependency.

~arvind

> Regards,
> Christian.
>
>> , and then the eviction fence will be added as a dependent fence by propagating with amdgpu_sync_push_to_job(). With removing the eviction fence from the VM sync at amdgpu_sync_resv(), then the eviction fence can be released properly.
>>
>> Thanks,
>> Prike
>>> Thanks,
>>> Christian.
>>>
>>> PS: Please stop calling the eviction fence evf.
>>>
>>>>>>      return 0;
>>>>>>
>>>>>>   free_err:
>>>>>> @@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct
>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>>      dma_fence_put(stub);
>>>>>>   }
>>>>>>
>>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo)
>>>>> Please name that amdgpu_eviction_fence_remove_all().
>>>> Noted.
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> +{
>>>>>> +   struct dma_resv *resv = &bo->tbo.base._resv;
>>>>>> +   struct dma_fence *fence, *stub;
>>>>>> +   struct dma_resv_iter cursor;
>>>>>> +
>>>>>> +   dma_resv_assert_held(resv);
>>>>>> +
>>>>>> +   stub = dma_fence_get_stub();
>>>>>> +   dma_resv_for_each_fence(&cursor, resv,
>>>>> DMA_RESV_USAGE_BOOKKEEP, fence) {
>>>>>> +           struct amdgpu_eviction_fence *ev_fence;
>>>>>> +
>>>>>> +           ev_fence = fence_to_evf(fence);
>>>>>> +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
>>>>>> +                   continue;
>>>>>> +
>>>>>> +           dma_resv_replace_fences(resv, fence->context, stub,
>>>>>> +                           DMA_RESV_USAGE_BOOKKEEP);
>>>>>> +
>>>>>> +   }
>>>>>> +
>>>>>> +   dma_fence_put(stub);
>>>>>> +}
>>>>>> +
>>>>>>   int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>>>>> *evf_mgr)  {
>>>>>>      /* This needs to be done one time per open */ diff --git
>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>> index fcd867b7147d..da99ac322a2e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>> @@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct
>>>>>> amdgpu_eviction_fence_mgr *evf_mgr,  int
>>>>>> amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
>>>>> *evf_mgr,
>>>>>>                                  struct drm_exec *exec);
>>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo);
>>>>>>   #endif
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index 1e73ce30d4d7..f001018a01eb 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct
>>>>> ttm_buffer_object *bo)
>>>>>>      amdgpu_vram_mgr_set_cleared(bo->resource);
>>>>>>      dma_resv_add_fence(&bo->base._resv, fence,
>>>>> DMA_RESV_USAGE_KERNEL);
>>>>>>      dma_fence_put(fence);
>>>>>> +   amdgpu_userq_remove_all_eviction_fences(abo);
>>>>>>
>>>>>>   out:
>>>>>>      dma_resv_unlock(&bo->base._resv);
