Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C85CCD199
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852710E4A6;
	Mon, 20 Oct 2025 17:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnHaFeT2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6196C10E4BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqO3Ngcq3Q9YeHd+plqGpnR89lxLeRagVT1Ib1uhfyLu2/0HrAk0KoNfm2hqspwbA4xSngpBJGRFequVJaKTpFGL1emIFhn2O8fAI6tBTChqUDLBmOsjVb7Gqmtpz4mpOi5r00jm+Yrwv+eT7BTI/AMz31p2Et1yr2Z6SCwfaGXrcdcT8IoRP5W5vxFYruOPdf8eNcHLZGskxt/V3n3DrXPIrnL/VvGIiRKvu4Bxi/8G2JBNBsIRDoRB6jcQ0TOyriJZIBBrZE90cMlza3tYyw5MKQBuinqOS4bMysBNXkBg0tb/d0kn9vgcUKELIe1o43WrxVf+72xK/EUwUTVHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQIGxMtZ5c9taoRR4m/6QKoj6+dDjXpF4PxazvcfMQk=;
 b=iCjmy297MO1gUF3QJdPxnuOS5ndMVLishGtsFVbGgoOx1sWzPIzZta7E5LkKxd8GxstcQxiFgTb4pWWduTAU4b+BxICeR9v4975mHUk+fz2IXUMemQmYw+7NzZimAk9GFvQKNnYaOMXUZKglrlZlYZ7V9u2vpS1SbzRCsW2j3PN4CZKvG0kQ7QjsxFbf5NCsIAUdnC5mxxMBj1vouM9uJWL3mLNUWH8gi+9vjAN/1nPgNUjjrCPmP5bf2+mdvidKAP4Roqt9hbWijcD0M6MrExf6+Zov880L7yV9I7q34NbIDrMcsEy5GgNburFSFvDNTZuclKGTBvtCP0XKvrQYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQIGxMtZ5c9taoRR4m/6QKoj6+dDjXpF4PxazvcfMQk=;
 b=DnHaFeT2qEAmZcXDV3X/Xyua8MexAIPP6BLKt0J9iPbaZudO5ttjOkBSbKupr1Lk6JiOmxU+uhDt/rwCuOtxhIIXmcdA+vnUTg9rBodHYVVZf8cAlzLNq39MtwQTm8b9RwyAwkx2Vb34lPrGEKq+goGsChH0pq74+/y75IbmpNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 17:33:36 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 17:33:36 +0000
Content-Type: multipart/alternative;
 boundary="------------hHYVvKEYUOTgTmG0JGZmaYFv"
Message-ID: <c5d8fca3-5d49-4e31-b864-e4deb70e1df0@amd.com>
Date: Mon, 20 Oct 2025 12:33:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20251020143016.23409-1-Philip.Yang@amd.com>
 <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
 <CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:806:a7::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5ce0f-b019-471f-0732-08de0ffecc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkZZTnFlbGprK2hqRWozYzVERXJtZXpaaXlldGxaVStYaS95TU93cWNkeFVP?=
 =?utf-8?B?YmVUYVc5VVlaRUx4YzZ3OHJhS091c0JNSmYrSzJjNDhFbDFsWkJuWUZoQk80?=
 =?utf-8?B?cFZTV21HbWRxSzlKNjdtODRPWXlmWjR6REtLU3YwMi9DZXR2dlpDSG0zUk5z?=
 =?utf-8?B?TlNIeHRSWWh4WGFIQmtlUHFTMVdJTzh6UUh6UWFjYVphVjNWNTcyRDMzSzlx?=
 =?utf-8?B?a1hGcmJzVVdtKy90MXZPcnVOdmNnMm1ESnJ5eWVRTG5wemk1SERuZEdJSnh0?=
 =?utf-8?B?dkRZRjNINjQ1ckhTeWpLdmxKZ29RdHpMYzdrMjJJREkxb2JoTlhkQk00OE5P?=
 =?utf-8?B?OG9XbUJQcXpQeFVLVHc4Y09tZXk3d0NQcmxKcnlubkZpM2V6eHZVOC9xRm1S?=
 =?utf-8?B?NVZLaUpUcUtKTS9ZeUV5QXNXOTFTSWJld09iNEdLckY2ME1jMkFOZ3QxS2FZ?=
 =?utf-8?B?bFpFN0xNRVlvR3dDNnRnZGRrY2FzZ2hiMmpmUk5hZ1psTnVsdVJZN2JKYnNC?=
 =?utf-8?B?ZmFwY09uMjQrS1pyZlhzOG1XUG5uazVZaU85ejBaSURaMHAwUnJ6R01WSk11?=
 =?utf-8?B?SUxoYVZqT2g2SVVWRlJDWTZPQnVFZkpZNmZRTGFMSWxZUTBpR2JyQVAxRU45?=
 =?utf-8?B?U3U2M1BWOHNYWUpqRUpmZ2dwVHVLaFhpZXhOQW9abGd6U1QxUzBBZFcxa0Rz?=
 =?utf-8?B?Y2wzcnd4Mk5MZWVuVW1NUWFzemtQRm1kLzA5TnVwNmJPQmtYR05vY3QzNk02?=
 =?utf-8?B?MC9GN0ZWNEFMalV3dWQ1cDRyQzA3Qlo1U01jV3BhTE1KS1N0QXNKOWRML3li?=
 =?utf-8?B?ZEU1eCt5cHI2VEZkSWxaQ29GODJJVUwzQ1RkbzZpRGVNd0RpMytWaWdxd1Fi?=
 =?utf-8?B?bnpRdVZTMXlMbkJ0NHRlWXdkZVBTNGc3VWpUYWlnZ2lUUWFuTkRSWVkrcDc1?=
 =?utf-8?B?Zzc2UTU0WTVsUDVYeFVaN0h6WVJLQ0ZWL2EvVkUyV0hhT3NQdnJYYTUvVFIv?=
 =?utf-8?B?dXRjZjJoZ0kySzA4LzFpUVhaWUNLV2pnSGptdUFPRmVUdDhkWW5ReUJjSyts?=
 =?utf-8?B?VG1pWGZTUGtoeG5wN25lNE94WXFqaithaGxOMnVRUE0yZ3VTL0V4ZHg4V3R6?=
 =?utf-8?B?czNXRWZKUkdBWmVBOUJ2WnpkeENvRkUrajF6d3l2SGpBRldYUXF1eG1BK0or?=
 =?utf-8?B?YTN3bTZqc0h4enV1enNnOG1raDFwRzRjRE1LaW56TTlKYzhoaWdQa3NPM1B4?=
 =?utf-8?B?TFJ5dWtjbnFtWTVGdm9CdnRZTVB3MGw5cWJweFJvV213dmduRFY3SE1xeTdu?=
 =?utf-8?B?VjBqdWg1YW04cnJBaDQ5U2t6Q2x6eUgxTGhlZFZjZzFlbWhsOSt3WDQ3NWhu?=
 =?utf-8?B?a2Q3N2pzU1lMUW9RdTdkVFBIeHpmOFBkT1NQZ0xCMW5QdEN3YXIrcVJkUWZi?=
 =?utf-8?B?a0QwbzB2Rk9pRjU0SktiNTExTjU1ZmZGTDBCMHUzZ040MGhOMkZiZnBJOGxn?=
 =?utf-8?B?aENxUTY5akdTaFpNL2p1MVZlN01IZ0JWNWpjU3J3U1BzZzJsYU1XSmhENHcy?=
 =?utf-8?B?ZnJ4UTRFTWxPNDI2Ry9pNkk2cWxzRnQ1ZlJPYU5tNUpOQ0J3b3c5T2hCYUNy?=
 =?utf-8?B?WGlsekJzUUZEWDVQZDBEcmNtckRjVVZKY1dJRHhwbG5QeWVIa1Zuc1JwNGFn?=
 =?utf-8?B?K0haRjJTbWdZNVd5N0Q2dDhMemZPSXluWkFwbU1nMDVtYzdITFFaOHZqUGpt?=
 =?utf-8?B?M2RJQkNpM2VOWGZQbFhWTmx4aUlDUWRBYzN1Z2M2M0tqZmlZNmtxUFZua256?=
 =?utf-8?B?N2FEbU1yWE5scFl3MzZHbml3eURZcG02eUZkNzZyRndwYVMvaklXTExVejdB?=
 =?utf-8?B?c2N6QmFldllmSXRLRWEvMUk0MlBQcVAzZFNxWW9Ua01DUHROUTBIWm5PeFlW?=
 =?utf-8?Q?KL2xJWMfKQseJS0x4M4H5079PLGPIkf3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZTYVYrTmxrU3czY2V4ZWpKVVpKa2dWTEZic1NUcGxua2RzTzBsTk9Ia1c2?=
 =?utf-8?B?S29pcWZubEZSbGJERm9UMTRvVVpKOGZxSk04YkNha3U0SFk0RWQ5TWxXNzJ3?=
 =?utf-8?B?QjJ5U0svZmk5bzgvcDBSMTV6M29mSjZhTmVueWRVV3Q3NjRIUk10ei9mVkx5?=
 =?utf-8?B?cUhNQ1QxZjl2RWxyNlVmU3NMRGhHc2xzaHFTZmZaMm5pNU82SXhPRVQzeG54?=
 =?utf-8?B?eWtXSS8xMWlEcm1ZY2NsczlnTE1WT2dnZFdzczJCYXFPRlM3RkhnQ25XV2dC?=
 =?utf-8?B?bzlOTXFmSmtjQ0xSRjZoRkhlNlYvUmpTemJ5TERNQlprMWthbkMvd04zTUlZ?=
 =?utf-8?B?WDg2WDlhSUNRUVdTcTA1MEhoSElnVDUxbGl2Wjh0ang0MGlVT0VLL3JxUit1?=
 =?utf-8?B?dkZ6RG5zZ2JLSlJWME52RDIwc1VRME5TSVRpOWJDMS9kQ0Q4ejBLVFBhZDZ3?=
 =?utf-8?B?YmZuK3ZndWZFR1BrZEtXMFIyVkFGNzZyK1liWEJ2OEF6YmVIdDlwRlI4Q3JN?=
 =?utf-8?B?UWxYTlJUb21DR2c4T0cxSzh6aEFXV0l0MndQdHVTSkJ6S202NHZ2MUJDUTVW?=
 =?utf-8?B?Z0dVSEQxSWp4TThBNGRJblk4VU80WWJ6Q1lneXFTQW5VVnJpZXZTN2VIVitr?=
 =?utf-8?B?T3pUZFRTZzVlZnI1UWpwaHdZR1hlc3pRaFZqK2s2TmRmcW90Qm5jemdFK2dr?=
 =?utf-8?B?eDdPVnpHbzFldHRhUWJSWnkrdGxFWkNkL1pTZ205K3Ayd2txT29meHZSZGpi?=
 =?utf-8?B?bitsdUlWOXdJVWN6K0pFRUdzb0liZ2ViUW1pOWxMT0YyK3hoV2ROSFB5RWR5?=
 =?utf-8?B?QXJzRis3Z0hhbjdIZkU3MjdudnRCazhnU0FnSjVNK2tlN2JKblcyY2JZUDBL?=
 =?utf-8?B?UVZyeDJENnJkY3M2SExxUkdTMXlsclR6RUpZTVB1S3JRRnNOVTBaWDk1SDBk?=
 =?utf-8?B?aTR5NkJEaGxtV1BDRWdldHZ5SkxzZ09pVHl1SlpwQWxaVW5PTGkxa3liMUVD?=
 =?utf-8?B?QXJ6NHN3RDZ4Yzc1Y1BvQlgrL1B5L0hKdys5UERSZjVSeVBhYWtacDFwVG1U?=
 =?utf-8?B?R2YrcmpEc3c3UmRVZjJONXQzUjYwMXpmSm1IN0NsSmxQUGp4VVorb0xEVWhV?=
 =?utf-8?B?N2lISTN4Tm5WWHNpSjk1UzRaN0Nrc0tJTTFOZVJMWkJINllEOEE1ODhVeGpw?=
 =?utf-8?B?cDVYd041cGMycndScTNtbXg2R3RpZXNtOHlDUnlvcjNRekFGbGQyemgvVTU2?=
 =?utf-8?B?SElyZ0RkS051Z05lSG9CL0F0WER6RUhGSExnbWp2aERXTGUrZGRQQ1pDbHpt?=
 =?utf-8?B?MXMzSXpteE5zRUcyT3N5MnZ5MGlxcm40c25oMnBmc1BEZnprd0Mxc0NnaXJy?=
 =?utf-8?B?aE02b3kyZEJUOWcxSlhWS04ySCtyckdJL3VlQkpEZEhoS0Q1Qlh6SkhQWnV3?=
 =?utf-8?B?V24ycDA2R3FGMjFESWZRdE8xWEdCcUlYWW5WME9kUERnY2duMFh6bHBFSmxV?=
 =?utf-8?B?R25oKzljQmdmazBQMVg1QWUvWGxkU2hpS2o4eG5aRFRqeTZxK2VhSkdvN3pO?=
 =?utf-8?B?ckhrRU9CRjlCWnRrV2NwVHVDdjRvTXB3bWdxU2Jtck45V0xVeWdNRlE5TTJQ?=
 =?utf-8?B?SDl2YU9KTEIzZ2xjOTNReFgwR08yYU9BdzhtOWRudUo0cGdxUjc0Ync1MzZl?=
 =?utf-8?B?VUFVY1hJL3NOTkJtSmk0cXNpaGtOSnhOYnRyZnYxZ3hOeWZnUFNLZE1ZWTY3?=
 =?utf-8?B?S1pISFYvdDEvQVRQS2d3S1p2dVBYTWxwb0pGRWR2aEcza2VpV2J1eUdrUjh4?=
 =?utf-8?B?c29uTTh6cHRqamgxNjVDTnlDVFZ4UkFmWHpsL2g3aDlab0p2S2x5SXMvWEZK?=
 =?utf-8?B?R1V2T3lwY3N2WGx6RTRKNGtFS0p3YWxwaGZiOE1qVzNJcHIyeE9MaGRPSXlz?=
 =?utf-8?B?b1lJOVY3dS9jdVVmbzBYQzN0bk5HVlJRVUl6TEFpSWZQV2RwQ05qTEFFQWVS?=
 =?utf-8?B?SW15UzdURVNaZlFtOWorUTZPRHNaWGNudFkvR0VxQWI4dDBlZ09Tc2pmVEhE?=
 =?utf-8?B?NWxiY0t0K1ovMDlieE16UlM4VmRIMFJJeER4NUlEZ0xCM3RnUEpBbFhLb3VE?=
 =?utf-8?Q?XXi0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5ce0f-b019-471f-0732-08de0ffecc8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:33:36.2499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThzLmOzpl1lvWiRyyDxxqLL7IuVteJUJT8hIcepw4MpfGR9rwvO3TqX8xlpLNpes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

--------------hHYVvKEYUOTgTmG0JGZmaYFv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/20/2025 11:24 AM, Kim, Jonathan wrote:
>
> [Public]
>
>
> You can see this error message on CTRL-C or gpu reset conditions.
>
> Those don’t seem like application race conditions to me i.e. the app 
> can’t do anything about terminations it can’t see coming.
>
> It appears any bad actor could spam dmesgs with these error messages 
> if they wanted to with the way the driver currently is.
>
If this warning message comes out due to some unexpected things 
happened(like ctrl-c) I think user would not be surprised to see some 
warnings.

Regards

Xiaogang

> Jon
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Chen, Xiaogang
> *Sent:* Monday, October 20, 2025 12:00 PM
> *To:* Yang, Philip <Philip.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue 
> buffer free warning
>
>
> 	
>
> *Caution:*This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
> On 10/20/2025 9:30 AM, Philip Yang wrote:
>
>     Only show warning message if process mm is still alive when queue
>
>     buffer is freed.
>
>     If kfd_lookup_process_by_mm return NULL, means the process is already
>
>     exited and mm is gone, it is fine to free queue buffer.
>
>     Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
>
>     Signed-off-by: Philip Yang<Philip.Yang@amd.com> <mailto:Philip.Yang@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>
>       1 file changed, 3 insertions(+), 2 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     index 4d4a47313f5b..d1b2f8525f80 100644
>
>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>
>               bool unmap_parent;
>
>               uint32_t i;
>
>       
>
>     -        if (atomic_read(&prange->queue_refcount)) {
>
>     +        p = kfd_lookup_process_by_mm(mm);
>
> p->mm is null, not p  because driver set p->mm to null. But 
> still prange->queue_refcount is ref of queues from this prange. If app 
> unmap this prange app should have destroyed the queues associated with 
> this prange already. If not, it is not driver issue. I think driver 
> should send this warning anyway to indicate there are queues not 
> destroyed by app before app unmap the prange. It is an app race 
> condition, not driver.
>
> Regards
>
> Xiaogang
>
>     +
>
>     +        if (p && atomic_read(&prange->queue_refcount)) {
>
>                      int r;
>
>       
>
>                      pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
>
>     @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>
>                              pr_debug("failed %d to quiesce KFD queues\n", r);
>
>               }
>
>       
>
>     -        p = kfd_lookup_process_by_mm(mm);
>
>               if (!p)
>
>                      return;
>
>               svms = &p->svms;
>
--------------hHYVvKEYUOTgTmG0JGZmaYFv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/20/2025 11:24 AM, Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas",serif;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">You can see this error message on CTRL-C
            or gpu reset conditions.</p>
        </div>
      </div>
    </blockquote>
    <blockquote type="cite" cite="mid:CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal">Those don’t seem like application race
            conditions to me i.e. the app can’t do anything about
            terminations it can’t see coming.<o:p></o:p></p>
          <p class="MsoNormal">It appears any bad actor could spam
            dmesgs with these error messages if they wanted to with the
            way the driver currently is.</p>
        </div>
      </div>
    </blockquote>
    <p>If this warning message comes out due to some unexpected things
      happened(like ctrl-c) I think user would not be surprised to see
      some warnings.</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Jon<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    amd-gfx
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Chen, Xiaogang<br>
                    <b>Sent:</b> Monday, October 20, 2025 12:00 PM<br>
                    <b>To:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Kuehling, Felix
                    <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH v3 1/2] drm/amdkfd: Fix
                    false positive queue buffer free warning<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" align="left" width="100%" style="width:100.0%">
              <tbody>
                <tr>
                  <td style="background:#FFB900;padding:5.0pt 2.0pt 5.0pt 2.0pt"><br>
                  </td>
                  <td width="100%" style="width:100.0%;background:#FFF8E5;padding:5.0pt 4.0pt 5.0pt 12.0pt">
                    <div>
                      <p class="MsoNormal" style="mso-element:frame;mso-element-frame-hspace:2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly">
                        <b><span style="color:#222222">Caution:</span></b><span style="color:#222222"> This message originated
                          from an External Source. Use proper caution
                          when opening attachments, clicking links, or
                          responding.
                          <o:p></o:p></span></p>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">On 10/20/2025 9:30 AM, Philip Yang
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>Only show warning message if process mm is still alive when queue<o:p></o:p></pre>
                <pre>buffer is freed.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>If kfd_lookup_process_by_mm return NULL, means the process is already<o:p></o:p></pre>
                <pre>exited and mm is gone, it is fine to free queue buffer.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Fixes: b049504e211e (&quot;drm/amdkfd: Validate user queue svm memory residency&quot;)<o:p></o:p></pre>
                <pre>Signed-off-by: Philip Yang <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--<o:p></o:p></pre>
                <pre> 1 file changed, 3 insertions(+), 2 deletions(-)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>index 4d4a47313f5b..d1b2f8525f80 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>@@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unmap_parent;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;prange-&gt;queue_refcount)) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_mm(mm);<o:p></o:p></pre>
              </blockquote>
              <p>p-&gt;mm is null, not p&nbsp; because driver set p-&gt;mm to
                null. But still&nbsp;prange-&gt;queue_refcount is ref of
                queues from this prange. If app unmap this prange app
                should have destroyed the queues associated with this
                prange already. If not, it is not driver issue. I think
                driver should send this warning anyway to indicate there
                are queues not destroyed by app before app unmap the
                prange. It is an app race condition, not driver.<o:p></o:p></p>
              <p>Regards<o:p></o:p></p>
              <p>Xiaogang<o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p &amp;&amp; atomic_read(&amp;prange-&gt;queue_refcount)) {<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Freeing queue vital buffer 0x%lx, queue evicted\n&quot;,<o:p></o:p></pre>
                <pre>@@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to quiesce KFD queues\n&quot;, r);<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_mm(mm);<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p)<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = &amp;p-&gt;svms;<o:p></o:p></pre>
              </blockquote>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------hHYVvKEYUOTgTmG0JGZmaYFv--
