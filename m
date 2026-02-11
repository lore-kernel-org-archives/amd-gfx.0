Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB9AEB597E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 09:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A2910E0D3;
	Wed, 11 Feb 2026 09:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="laGbY1bs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC5210E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 09:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8GSBnbtG94poXFlaMfJc5Id1V/PZAfsSb6Oplk4Lr9y8nxLjsm8FDHO3Ti27z+oKwsLy6dTzoOGWbr7Cxn7O2B7ZQhTSsDlKcDA0oZWsy80/d0p9txzf7tkI71eRou57iJhoIVhtnMXhmwhszOTmOtOdjPco9CmvSnTpZryKsBmoVqLVJ2v7IeulnEJ1ARRWcFT8ySlxC8PcJfVUmzUCNrfnkh813GAes9SLPJBs2iTRUX0QzQwvQaiJ9QDRHcYq2SfoyUtPueK6WeHVuJCRFDM4/NQgsUR1kYS3T6SrIUpJ9r7aIKX34uIHeZMb+75ubEFNieXOXilAyZxMqh8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nwLzTAzht5sDm24fC1r+Pj68biNfoKy6fYUCyrXLLU=;
 b=L6DePkl1Ycvc8WKeztMWO5wfRHbPDTmeyknSYQpqnbju/mc8CXhgtDdyU6i1WEF3Uei6Ojw0cokUulQ6GlIFD1+8okkLH0VI5XDDujvTHohNkI7WUenMg9kzdp40a57JppQy8hyxLp3NJDTRFXvG1rLQWhb8aeerDm5dyyBQtR/tqpspcOmALxFkKNn5Gu0woNLLr4urp6Te1FURJLEvdD6ZeZ8gJ1LUrwzCx1zvYZ+LaTB40WrtSM+dAtXlvzQWrHo4BS3+Hg+Jc+c/HkBCSJTPvRSHeRd4739eCuNllXRFz0nQNfAxTW9XGTfCKwldblcUifXxoJLy137aBpwwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nwLzTAzht5sDm24fC1r+Pj68biNfoKy6fYUCyrXLLU=;
 b=laGbY1bsuv1uf1AyVjAOuFM3HtR8xJcQOCf/pZuYUuOaQaocn/vryJ/4tG2CXdC+cNTFtS+QCF0bKQTYL+PZpBaqTYglSAL7T/FndMwz59HgG5FuUkUHqEiYqEoYJNlgeB2xZnGrjTGGvcrjksOYlh3cCIcvPQ1LlAz0NDH1CY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 09:14:29 +0000
Received: from PH0PR12MB7094.namprd12.prod.outlook.com
 ([fe80::d6a4:44cf:eb70:f247]) by PH0PR12MB7094.namprd12.prod.outlook.com
 ([fe80::d6a4:44cf:eb70:f247%7]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 09:14:29 +0000
Message-ID: <7b30cacb-7ef3-48da-8db8-c1e91f485b9c@amd.com>
Date: Wed, 11 Feb 2026 14:44:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/swsmu: Move IP specific functions
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260211091255.125037-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260211091255.125037-1-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0137.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::13) To PH0PR12MB7094.namprd12.prod.outlook.com
 (2603:10b6:510:21d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7094:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 86060ce6-02c2-4d01-c1d1-08de694df5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3JUOFlDRWNIdjZjNG9VaDhjK2tyWi9WMGx5Q3JleFlTNHJPWDB3a2gzZFpC?=
 =?utf-8?B?QjlFRTduZ1FYTnZHb0xWMzlXUUhOZ0FMa1JQRThDWXZxamVvSTlkbnp3RTRq?=
 =?utf-8?B?SlVvTjFOQi90SHA5amZYWmlWdkZvYmhxYUNyL3dWQUR2SlRBWGxmSVBDcFF6?=
 =?utf-8?B?TnN2TGlWS0VFc21xYXZjTDlHdnhLWlM4MVU2eGlHM0lGVUEzUEFBVy91dXlU?=
 =?utf-8?B?NGNtN2lpRVQ3OWZtNDNiVWZaWWVlNWQ5MHU0REJWaXgwVHpybEIzZks0aGk3?=
 =?utf-8?B?VDdPcjVYbEh2dE83N09lMEFTUW14Nk5wd2RHMU5JY08xdjIwdDFaUktRdjlT?=
 =?utf-8?B?UkVvZm5sb1dCMjlGWHRRQzJCRFVJR2NuOGU1NUhZVGNOSVZycHVpaTFYTERB?=
 =?utf-8?B?eXVrWG1vZ0FvYjk0QTlpMVRoREJKMUlXNHdoYjdkdHRjWXRNNjRDU040NS9N?=
 =?utf-8?B?SFNhTlRHZmtFbUFITWZWTnUzNmc1L3BJRTdCaXpWR3ZhdzFqSkh6UGVKR29n?=
 =?utf-8?B?bDdwWGZBM3RsTGdPTzRMZllQTnQ1TlovYnhSMXhSRXJ3eUhFU1JUejZYeHls?=
 =?utf-8?B?VnhpemZUUWZpOHZEQWtaZTN6aVl4UGt6OHI5SVJGQld0RXdIL2FVeUJXMmFp?=
 =?utf-8?B?UytDNzlXTlNGQjFLY0llMDRiYkphNjdNZHk5bG9NVjRnNmdqZ0wvNndOeGhC?=
 =?utf-8?B?T2pRejh4dTVEOGRuQ1YyVkY0MStmbHpjZG9zczNCei9DdlJHTkt3aHRqVTRn?=
 =?utf-8?B?SmxvYnpVdTQzR1JySlEyVURET3Z4Nlh3VXM3RkdmbGFZZzNZVCtVeFJqeEEw?=
 =?utf-8?B?QzVZaXZwNm5rd01mSWtoMHR0bUU2amh0Z0MrWEZlc0pXRldWMzZXRmU4WGU3?=
 =?utf-8?B?Q3dRUVlHMU1GTDY1di9RUEdOTS9BOThLbmVBbzRMUUdIMTBPSlZkNyszSG9h?=
 =?utf-8?B?QU55UTdtZ0hqa0w5Q0hVTUhoT3ZtdWJ4UmhlNDdYZFVFZWtqd0dUTUo0ejVP?=
 =?utf-8?B?VDR1YWkzRklTbTMvSG8rYlNxU0w3OVdha2pTaGx4QzJnRG1zYWJYejVlZkh4?=
 =?utf-8?B?UGgxc1lrbUdXM0RWTUVOMUlBTzBEVzUxT015TmhxN1RFby9sWFYyU3JUcVFw?=
 =?utf-8?B?SjBGMW4zVUl3d1A1TlBmd1QwUUdvZDhtYldVOGNvMGlPYmhkTCsxMHAzcU1V?=
 =?utf-8?B?MjJoZ2wzdE5JYzUrZys3SklIM0JxUE9BOFE0MHd5c0VHbmljWkdXM2NUc1Bq?=
 =?utf-8?B?VlJ6WmJnTnNIN3FoRTIveGVuNThrYzZMb3BTazRqMlRESzFlTG9nSC84ZlFS?=
 =?utf-8?B?TDFqWDZVK0RSbDJ2bXM0bm1aWkZzTkkwNGhYR0VuZHV3VS8vWlIwVXN3Tlo2?=
 =?utf-8?B?VjFHMDA4cWRnSE5xaDhXVlRqb2NIVWhBcTBYVEEwcFFqRkRXL09QMmV2VnVZ?=
 =?utf-8?B?c1Q3Y0lia3o5V09tRFd4VEtXK2hISXZxRmJId2tEMGhNYlRCOUNSRlBiZ3VI?=
 =?utf-8?B?N2VmeVZPUGlOQ0RwNzBMRzRacU5lS2RoM0R1dkNLVnVkbkhZZURJNm4vMHUx?=
 =?utf-8?B?QnFCSkd5c2crMzVFRE4xZTFhN2FWQWg5QzN2bVBiaW1OL3dhSGVyRlJNWlo0?=
 =?utf-8?B?ZlBrcUp0RnppVlpLWURJK3ZUMWFhUW1WNkxPa0hWUDlzaHhhWjRaUHcwSU91?=
 =?utf-8?B?OWE1c1UyVlZKaFB0NUN2bkZEQUZRMGlVek1JcUE2R3ZuZG1ZZFMrOVZTanBM?=
 =?utf-8?B?aUoxVEJnVWc2NkdFeXFwMXJwZnVOc1orNnQ0MERMaHllMUFaWWNlZGNHNDVx?=
 =?utf-8?B?UDIrT1ZNaUg0WnpYellKUzhSUmRmOWtZdmxORHFoa0pvbDkyZVRwTEhRK1JE?=
 =?utf-8?B?Qlc2YW9uSXRZL2dNYWx4Rms5SGdGUitYT2cvRVRNcmtrRVVTbHRiL1dINWdY?=
 =?utf-8?B?Z2Zzb1Axb0FqamdjSlBqWWVBWVp3Sm8rSUxGNWIvYTNJaWIrNSs0U0FzNWl6?=
 =?utf-8?B?S09RVWx5a3hvN3U5VnBZbHJ0MWlMOGRtS2RnT2VPcGI2eVhjRmhIY3ZjODYy?=
 =?utf-8?B?WVFvVWZrMHgxMyt5MG1lbnI2NmlmcStOemdNaWRlbGhmT1dPcDNtbzRCS1pz?=
 =?utf-8?Q?CiHM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7094.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVnWnI3WDdhSXFGSDR5bWlhQWd2TjMvN0kwZVl0R1VGei9yMk9vWHJ2Q1B4?=
 =?utf-8?B?VXorRWJEbjZucWNlZklKUUVrZmQ3dG9FUUgyZU1hajRFTGpDUGFETGROK0Z5?=
 =?utf-8?B?dGFOeW5ldG9wOHdGRXNVNGg3SEQ2dFZHQ2N5bW1FcWZBaTZuYVNSTDA0RFdY?=
 =?utf-8?B?TXk2Ym5lNGkzbVQxcnpyaDIvY0tMT1AzeHVZTGU1ekFabWZRaUZnMER3eHJ5?=
 =?utf-8?B?RTgxWXhhRDFmSm1KbzJMMTc1NitDRVcxTGVQRURkUDlFbXBVOVBKTmh2eHow?=
 =?utf-8?B?KzZKL2s0Nlp4WjlhMklnUk5BdE9IeUd1dzRxbkNNZThpU1gwbG9hRGo0S01l?=
 =?utf-8?B?RUNFYW4xSVUxamdRNTR5TGhnU0pCTHpnREVncDRmM3RIRENEcXFHaFQxL2Jx?=
 =?utf-8?B?bXExWDZmQUI1N1l4ZTJuK3R1ZTF3VlhGOTZSS1hWREhLNXZBbkROb3diN0Ix?=
 =?utf-8?B?TFFuaktETHRQZ1ZDTTlGam9JUUdvRzFtMzk2V2xhSTluQlV2eTYwS2p0RmJj?=
 =?utf-8?B?RGNwS29reW1CdDVKVjlUbzNGcDBZUytvRjdodWNvSFYvWG9laE5qUTdxZ2xS?=
 =?utf-8?B?cXc5WFFUNW54S0lmY0M0Q2xKa085Vy9neFdxbUFKK24yR0djRWlCemlaUXQz?=
 =?utf-8?B?Z2VMOFFrQ3RuWGFwcGp0U2taY0RJNHg2azN0UVBTR0VMeGNhRXZPaUd1b0JS?=
 =?utf-8?B?ekoxNDRTbHRpQ0hTTERvZ3VoNmcrQXRaYk1UR3dxY2xqQjhHYjZTT01JMGFz?=
 =?utf-8?B?K2VEQStBT2ZvQ2J3U0RiSzljZStMdmltVGZ3ak12NDh6a1lzTXF4ZDc2bTJx?=
 =?utf-8?B?MmRZU0lESmgvMnJueW41SEJvaWlEM1dRVW1lVXBiaUhFYWhSK3VHVGVBVDVB?=
 =?utf-8?B?SUtZeW90T1dDMHlXbmRiYUVnc3hwOG9PbWMvenJOMDlWTnNFWGZpUjJQdC9E?=
 =?utf-8?B?OE5aWDdPMjFzampIT1hxRXBGbzJpRkhROUJ2RUJXeVh5Q0tDci9LRnVFZXVK?=
 =?utf-8?B?N1JmclRUVUt1bkk5RWlmZ1Nnd213K2ZzQ3U4UFN4ckRkVFNMZWpxTnJBZEw2?=
 =?utf-8?B?WVMvWDhKeVl2bWd0RUc0MUxreXltbHREc1lxUExVTTFDRkdWandhUHhmRTlj?=
 =?utf-8?B?VExzTmtTY2J4a1JkRGZmaE5ORkQ4UXZjSUpDWGczaVQyKzNkUWtYRG5jeWMr?=
 =?utf-8?B?Z1dqZ2RuYUU4N05QR3JLbEJZMVJwVWl1NmZPTzhhUFVzRmgvcTcxTXlyR2R1?=
 =?utf-8?B?VUJuMGFPVFdWVjY0eldxUk5MODlTV2VGY2tWRnQrNjBFMUYxVFlDaHdKeDN0?=
 =?utf-8?B?cEEwdTBicjFyNEZtMUd1RlY1cmMwZTlPYTdWRWNFNWxWWGI3azNXZ3RFUzZj?=
 =?utf-8?B?Ulp0ZTliQzBxaEZMdTFZTmoyMERESTV1QU9RbjhJb1RHY3RibHBEUHpaa1VR?=
 =?utf-8?B?TjM5Z3ZBeUlFeTA4U0JoQUcyM2JMZVpuODB6WXQ4a2xnTXhyd05TYlNJSGkr?=
 =?utf-8?B?dVRIR296di80cXVnaWJ1M05uUDNYdVFiTzdUcWRiT1RNMi9oZHBxVmdmTUYz?=
 =?utf-8?B?UVpiMzN6dWsrd1VPWERCOGhwb2phRURTMDZsQlpsQ1RHT2hCV0NvYkdsSFF4?=
 =?utf-8?B?bjV5WDZwdlV0N05VbjhlNGRWQ3dTY0sxUm1WYVRHazVsY0EzRmVLOVh0dXEw?=
 =?utf-8?B?VDV0N2p2ZDUxU2pGdllyRnRDTzRlcjlaL3dIYmlZdDZkYy90cUlNMHdqcEh2?=
 =?utf-8?B?UWdQb2dtdWd4YzhlL2ovUjhNY3dTcXVyVjUwWFRnbXk2NFUxbmVFVjErZTVC?=
 =?utf-8?B?VU5yUEdqZ0UwNkNtR1M3QndYNXdhQlVWTGRyYjk2MFJ1MzRXT2ZkdVJVS1Fi?=
 =?utf-8?B?TnZpa01VNzQ3QUZLblV5MWFJQSt6dlJ6ZzYzTXZRbVlUdENBd2ZlUkVFVEx5?=
 =?utf-8?B?RnBDc1EwbW5jYy9wcFJUcXdwTnU4cEF2T3RJMjZ0QjdLeFJRWnN2cS8zQlh4?=
 =?utf-8?B?YTIydUt3UDZjVkRwTFJMS2lLa3oxWWxZeEUrZGV4T01IODVTNStnejdzYThh?=
 =?utf-8?B?clo4RTRhekhIendXNC93dzYwOHVHeU02MjNpdGFOUFI0L0VVTlR6VXZVcDZp?=
 =?utf-8?B?UGdzUDdxZzdmdjA2WlpSODhVa3RSS0JyT21yYzhDVlNRMUpLQytVNXoyZWJV?=
 =?utf-8?B?WjJJSlJyREViS3FxMXZXb1h3TnJxdnRhcEVKVTltZFFSS0crdHQwa3B5VmtX?=
 =?utf-8?B?UjF2cHMrK0FPMC9ydEdBM2RCSHozWFR3djBlQ0lxUnFUSFdkL3hpNGdpK01O?=
 =?utf-8?B?cFl6OHlhWFlneFl2aVhvLys4UEEwUEpQays1SHFWb1p2SjZNNmdNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86060ce6-02c2-4d01-c1d1-08de694df5b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:14:29.2102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWI9J2g01N44jSSw15fUMbrioxHcWwhWgJbXUNfYYwJBrOrhg4sopHq4GmUhGQ0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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



On 11-Feb-26 2:42 PM, Pratik Vishwakarma wrote:
> Move SMU v15_0_0 specific functions to IP file
> - smu_v15_0_0_set_default_dpm_tables and
> - smu_v15_0_0_update_table
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  7 --
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 66 ------------------
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 68 ++++++++++++++++++-
>   3 files changed, 67 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index af87c31ca9a4..ab4a64f54e79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -226,8 +226,6 @@ int smu_v15_0_deep_sleep_control(struct smu_context *smu,
>   
>   int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu);
>   
> -int smu_v15_0_set_default_dpm_tables(struct smu_context *smu);
> -
>   int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
>   					void **table,
>   					uint32_t *size,
> @@ -241,10 +239,5 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> -int smu_v15_0_0_update_table(struct smu_context *smu,
> -			 enum smu_table_id table_index,
> -			 int argument, void *table_data,
> -			 bool drv2smu);
> -
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 37fe4c1bdbd9..a2f446d38be8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,72 +1726,6 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> -int smu_v15_0_0_update_table(struct smu_context *smu,
> -			 enum smu_table_id table_index,
> -			 int argument,
> -			 void *table_data,
> -			 bool drv2smu)
> -{
> -	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct amdgpu_device *adev = smu->adev;
> -	struct smu_table *table = &smu_table->driver_table;
> -	int table_id = smu_cmn_to_asic_specific_index(smu,
> -						      CMN2ASIC_MAPPING_TABLE,
> -						      table_index);
> -	uint64_t address;
> -	uint32_t table_size;
> -	int ret;
> -	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> -
> -	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> -		return -EINVAL;
> -
> -	table_size = smu_table->tables[table_index].size;
> -
> -	if (drv2smu) {
> -		memcpy(table->cpu_addr, table_data, table_size);
> -		/*
> -		 * Flush hdp cache: to guard the content seen by
> -		 * GPU is consitent with CPU.
> -		 */
> -		amdgpu_hdp_flush(adev, NULL);
> -	}
> -
> -	address = table->mc_address;
> -
> -	struct smu_msg_args args = {
> -		.msg = drv2smu ?
> -				SMU_MSG_TransferTableDram2Smu :
> -				SMU_MSG_TransferTableSmu2Dram,
> -		.num_args = 3,
> -		.num_out_args = 0,
> -	};
> -
> -	args.args[0] = table_id;
> -	args.args[1] = (uint32_t)lower_32_bits(address);
> -	args.args[2] = (uint32_t)upper_32_bits(address);
> -
> -	ret = ctl->ops->send_msg(ctl, &args);
> -
> -	if (ret)
> -		return ret;
> -
> -	if (!drv2smu) {
> -		amdgpu_hdp_invalidate(adev, NULL);
> -		memcpy(table_data, table->cpu_addr, table_size);
> -	}
> -
> -	return 0;
> -}
> -
> -int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
> -{
> -	struct smu_table_context *smu_table = &smu->smu_table;
> -
> -	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
> -				    smu_table->clocks_table, false);
> -}
> -
>   int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
>   				enum PP_OD_DPM_TABLE_COMMAND type,
>   				long input[], uint32_t size)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 4dc8f0095713..660335d7bda9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -233,6 +233,72 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	address = table->mc_address;
> +
> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
> +static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +
> +	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
> +				    smu_table->clocks_table, false);
> +}
> +
>   static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>   							void *metrics_table,
>   							bool bypass_cache)
> @@ -1357,7 +1423,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
>   	.system_features_control = smu_v15_0_0_system_features_control,
>   	.dpm_set_vcn_enable = smu_v15_0_set_vcn_enable,
>   	.dpm_set_jpeg_enable = smu_v15_0_set_jpeg_enable,
> -	.set_default_dpm_table = smu_v15_0_set_default_dpm_tables,
> +	.set_default_dpm_table = smu_v15_0_0_set_default_dpm_tables,
>   	.read_sensor = smu_v15_0_0_read_sensor,
>   	.is_dpm_running = smu_v15_0_0_is_dpm_running,
>   	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,

