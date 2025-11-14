Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968BCCE7AA8
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 10:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B26010EA36;
	Fri, 14 Nov 2025 10:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NA/Euet5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5652E10EA33
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 10:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X522zHeIfPGIJwvJtxxCaM5k55YmVld4E/k9UgakM/bDWwaoBWO1fhq0EMl+c9k81Lw63klu+zPalYw9yuzyOzLCdihoDaw/cPUIPgsR/C5yS1RDSgJ5528TwyOMENfQAL4UDUqdWh87yD33BlLJUFQrV/3WqhcHrIuyB0tWI69/dRftD7M14L/put0n0x68GSDD7YP0YWyzrckgXjY7XNEf9MBWjIj0Tg3SHsLolP0aPQmIT8rnxHidJiNnE9mLW4he700rWLZA/JVGUTWUU8rFnu/KDkGL10zED58c4nZS+0OtFuFt08kthWHYcpAG1Q0Eqlg7yIshHj5eqSd4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NPm7uDGmaUCn/UAEBGt9+q2CthXVczDCBBe2NzajHs=;
 b=iINbprkkfw71HQf4I4dc4yEP2MBgOH8eIIbCswsuVY6SNXAGPhTgsvxj9dkpSZia2Xq2V0TFDilYYyCgpCC1IrDfK535hfvrlpIJDZcqSNP/rSo5fwZ2R6c6lKn5Qci2WlMvpNxSDYQYK5L2Ab9yExvPRtQ8Gjw5D1mo2mVC6oTif34Tel/7dq+k4ZaSo4zGNG471vs02WMBk4kQAhnHi0fFWoAEdOkljS3bMSOYVgv6ekgJVf8ZduyjHCeJ4UmSXUQIObaZfvKhvYaPoNal+6r4Kk1cU6HhNx4sxxg2Ar0HJ3uFUSlHvMVloeWVHcMXA+iMg9gvdO68yJsWzfytVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NPm7uDGmaUCn/UAEBGt9+q2CthXVczDCBBe2NzajHs=;
 b=NA/Euet5wBIgR1WRKIvUSl/NcFIpApvTrphoLwFVW8raZXILbN+TyvhkGBuXirzC45Xzg0qqvVTaEvd9FWPzutiaRaI1B5rZ5Ngcmsq+oqAAaGw+Lxl/y51CHCwdRkRhje0ohuwyYG0mdODY2IlJjewqVDH8RiRSTa3xoIbUNvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 10:40:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:40:57 +0000
Message-ID: <7604807a-86ac-4e46-8690-3a605e9023f1@amd.com>
Date: Fri, 14 Nov 2025 11:40:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: Use amdgpu by default on SI dedicated GPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251113190721.258617-1-timur.kristof@gmail.com>
 <20251113190721.258617-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251113190721.258617-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2956ea-7937-4814-1e6d-08de236a4b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2hiM0NIVzBmRHdkY2tlTk9VcnpSb0hDczd2N01NaU5MNUVDNUZMS3gzWG5J?=
 =?utf-8?B?Vk9hekxUaHROZUczMitWZWVoT3hSdkFCc016dVFsNXNRK0lhSXBkSjV6aHQ4?=
 =?utf-8?B?M25hV2Q5SDdoc09IOHlXTTUzSlE3Zmc2RkI2YW85NHFNZzlreGsyNGl2ZVhw?=
 =?utf-8?B?VW5vQUhRL0VQdjkvRXhOV0tKMHdKeHlxQldTdW9NTm1aSUk3aE1FR3MrRXZY?=
 =?utf-8?B?YUtoT3NDMmVKSzFhZE9RclhWRWxPR09FbXRJbGNvdjMySHM0MjZXYzQxVmVP?=
 =?utf-8?B?S1dIOUhhclRuYU91V09WQTNUelUzNk10MlJud2FNNk1VNXNKWVBkNEFZdWZK?=
 =?utf-8?B?akxMTk1kT1dSYzBaaEVjbkpGWWdSUTdKYy9XVkNnMTJEL3pPTjB3L2F0d0Zp?=
 =?utf-8?B?ZnlZNmtSVzVTMXFxNjhJVTExRDNLWDV2QjkvWmRXbE9jQS81bGFZZUppOVUr?=
 =?utf-8?B?eEhlTTV0NHYxZWdaUHIvUkFtY1Zqck5yRVNyaWhicnA0WlpIY1FmUWZXM25L?=
 =?utf-8?B?TUxvbGxOSVRWOG4rYW94WG9EU2hnWmNIMXRyWENkSUZiTExndGZaTXQwdGRQ?=
 =?utf-8?B?L1F6ZTNCaFFRU1hqSWNwV3FwY3UzdDRyanZ4RlliRE9NRUZ4RFBSQ3plUER0?=
 =?utf-8?B?NzNaMUtoYkVsL3g0MXREVUh1RUMwbTU3OEtLdHhxa0plL1NZMGszWStYSFo0?=
 =?utf-8?B?Zkp1bzIwZFRzejlCNEFhRlFLdTRSNjFrVFpLYUdYRDhNc2RpcGE1K2dsZzE4?=
 =?utf-8?B?UGJIdTUvNHdXYWs2TDFJNEZISDNVOEN4STRMenQrbmtrc0VkN09XYTdCblB5?=
 =?utf-8?B?SWlkanpZWUJmTWFtcEx5R0M3bnhiTlA1eHR1QUZZV0VtVFovUEw5Q0xrKzlr?=
 =?utf-8?B?czBvREkwVk9oY2tHSWswYjhCeC9XY1BzbmpoSkh5RlRCa05SVVNCMmhWOHBX?=
 =?utf-8?B?OFJqUzBUY1lFRklSMzlBK3dDZVZ5dGRxS2xsajR1NTVoR1UyUGVKVFdsOTNR?=
 =?utf-8?B?WDlUZWpCU01IdU9iYWhLZWpIU2Ztb05MeTdjV0dBZ0FXVjcvMm43QzNOMzdV?=
 =?utf-8?B?K0wyRXJpUnZsRkIxa2p0b1VBM200NVE1SVRBWFJ6MGdCME52ZHpDNlNHSndD?=
 =?utf-8?B?UWRpZUZJZzdKUEVVQldZTDUycjE5d1VhRWN5bzRMTzlxTEVWUVUzaUdxQllF?=
 =?utf-8?B?QWl6d1k0Yk5CcTZZSjBpQWVRK3NlRTcyd1QzUEh6TWswQU1pRGNaellNQ3gv?=
 =?utf-8?B?N3JYR1FuVWR2c0MvNURBaUNkb0QzQUhBaTdxNStNMmVOMlRpUTJFbmwrMEJu?=
 =?utf-8?B?N21sUTQ5Y0kvTEptSTk0SndRZTNOazRHRFFTMVpmZFljOW5jSTJrRGh1NnVq?=
 =?utf-8?B?MTZmM3VIZi9BTWdWelRjY3M0dFJOR1NDcDdtdk81RGxycEZwWHB4d0xrN1RS?=
 =?utf-8?B?MUlsNjhzK09VOGNXbHlhK0kvV05pYlg3TVdQTHd5NEJsZkUvdFJzdk5ncHh1?=
 =?utf-8?B?UVBDSWw4VEMrTzRVcTVTcjhIU0l5T1dBV0liVjZZSFJnZWVNbHQ4cWdrS2d5?=
 =?utf-8?B?NmVrRXBDck1GaVRPSjgrNVBSR3BhaENXVlphWVBLL3hFVlBJaWk4eTAwN2Zz?=
 =?utf-8?B?cmltcGlJdWk0SDVtOHVMeW13RkYzSUFTT3NoRnBDdWhoZW9QZWVzNHdMZXdR?=
 =?utf-8?B?Q3RVYXp1NEk4c25oMm1oVjFkS2pkdEFBYkllanB5aUtic2FsUGZLc0Z5bW5S?=
 =?utf-8?B?eWlsRkoyUTFMTU94UVBjbm1sdW92Q3lKdFJPVXhJbDN1enptekNObFBTSkpm?=
 =?utf-8?B?Y3p3THBRckRUR0ljT2ZYU29WRU5ubG5tVVRMb1o2dnAzTjRFRXhPOXp1a0kw?=
 =?utf-8?B?VXNQOHBNeUFVTURkdmhkWDFaOWd1OERnRU5QdGI0N1E5ckttRE0xVFQ0MGF2?=
 =?utf-8?Q?QO+n1WrkSqCxWrdfDxmnAUOugkqINp/u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVlRWhLRmZOOUlmUHJOQlc2clVYRXFvYm1OWElIRkQrczNhU1U1dlBybWJX?=
 =?utf-8?B?cTltNFRiUkgzUk9oRzFtdjlhbzB6ZUU5NzlqVDJZMmNnQWgxbEV5Vm5vZUlh?=
 =?utf-8?B?ajNHYmFmV2FaazhiVlZHOUE0OTAydm5lSUV6cW5iSllSNVovYWtPbUlGU0Mv?=
 =?utf-8?B?LzRpUXo4UzRRaCs0UVFRNlNJRU1OQUo2d0lwanBnV3VQS0ZXRkk0YmZpUHNo?=
 =?utf-8?B?cDRkTUs3NVVrcGdMb0h6bFVuMFdycVFKdTlGdXV5ZzdkM0w5YXE4OU1zRldl?=
 =?utf-8?B?cDNtdjZhSkJWSk8xd0JoZERVYVIvcjRZclppVEszYWhoRVFWS0N1d3l6ajhF?=
 =?utf-8?B?dUk2ZTFLRGoxdTZzaXB4eXlhSmRNajhNUHZhd2pxT2h6T3RiU0EzSU01bHUr?=
 =?utf-8?B?dTg1Tlgxd3ZZNHowclJFeGJCNWpOSmUvbVZidkxvbXlNWEhYMzhKbEdDNzNj?=
 =?utf-8?B?MnlUVDJNRm5yQUd5NlA3YXcwUlIzTU5LbjltcWFERXVrSTJPTTF6dGdNWkdh?=
 =?utf-8?B?dFV3WWFpakJyajFXaWJ5VzlmT0FPSkxKdGFwZGw2R2tQekk5U3NOcFR4cU9u?=
 =?utf-8?B?RXNOV2owcitkeG1ZTldUQTZQYm5JVnp6T0Rldk5obW9hNld0SlNNTjBDUTNv?=
 =?utf-8?B?MklzV3VDbEFnYW5rWWdYeGgyRnZtM24zRURMOEhBWFY0V3kwL1lQVjRCMVlo?=
 =?utf-8?B?TFhXektpemlGelp3K1A1ZkZSNzZRSGhCM3RpZEpzSEY0b2dLMEJJSER0MDlk?=
 =?utf-8?B?WWJicElBSlM0SG81aXdPUTRIVUVEREVtZnl2NWlmMUZhOVZ4ZHlIdmlMa2VY?=
 =?utf-8?B?MUdoKzRJSER3WXlzd3ZxVnBjVldmQWpWNVB2azN5c1drZHYvUnZFOEtVSUhX?=
 =?utf-8?B?MlVGZkFXMGt0M0xpOG5SbldBTlRqNWNRMGNXWmV4MVNUUzdXQkVVMmxKZWNt?=
 =?utf-8?B?eXArb0hnNmk1d1ArSmsyTDVVdlNIa09ZQ0h2MjVaU0VqdlFQM2o5eXJKOTRS?=
 =?utf-8?B?Q0FjVkhycDFaUXBwY1RCQkhRcG9VeHgvMHRFZmtmT0RqbklBdmw3RVNZNG8x?=
 =?utf-8?B?RG5mV3NYWTNBeTJleTkzRGwwQTk0QlRoUHB5c01LdHVCSld6OHBnaUExR0J6?=
 =?utf-8?B?OXFKaHlsTUltczlWQWxKYW44LzBuQXZvMTc2LzNlT2EzekIxbHQrWjQycnNk?=
 =?utf-8?B?TElnd0sybG02VisycVAvc0RVdXNjQ1p2WXVpdXhlVTJ4R0R2Mm9meFNJSGlD?=
 =?utf-8?B?bkhKMUh1Mjk0Rm1xSnZqblp1VmVIQy9NWEYxTFptdFg0WXFuRU1mTnk5a1g2?=
 =?utf-8?B?NGxpbzRKaFExMXhGcUNnRlBNdEd2OTJ2emxtTnNHczlZSURPc1hxalFoUGR0?=
 =?utf-8?B?OHZaWG9yZDFJemR6VHZPbVdSMlhGdWo2K1Q1OFZiRFBuRk8zWW1ndnUvOFRB?=
 =?utf-8?B?ejYzUzJMeW41U2k2MEJCTWZrN3NaZ0cxam9XUXBWdEFzb1RybDJTeGtDOENq?=
 =?utf-8?B?ZzRmNHZJdGdpdkFVWGd6aHozY1dKa24zck1jU1ZFUGtuSDJUOEN2SEU1ODBw?=
 =?utf-8?B?VUdaNWRTbFVkNHlhUlJnaUJHSklNaG1McmxNNTY2MDkxaEJZS2oyWGtBeWx6?=
 =?utf-8?B?VUhYTmtuK2d1cVNrRUZDajNSYjhudHIzRFBjbXc2K2svSVJjZUpncGpIUUV5?=
 =?utf-8?B?dTA2L1l4aTBoN1B2UXRHS3R0UVJONWpialZTRGtWSDlGSS8vb1I3aVpwV0I4?=
 =?utf-8?B?dDRHdG9wMlFXc1RmSElIaklneXJNRDZIdGg5UVJTTDRFNHJvQjFMWUlORUVa?=
 =?utf-8?B?NWFFSXl6SjI4dHJhRVFoWWpWTDBndFhOQTBWWFBZZGFOZUw4V2k5eUR0cS8w?=
 =?utf-8?B?dXluemFKelVWTzhzVnBUQThZYXp0RVVOSFZzU1F2Zy81TFZvaWdaVDdlaEMy?=
 =?utf-8?B?aEg2MDF4TUsweHNqdkhLVytlc1BtR1RFWFdkTis2U1cvRFVYQ1FveDAxSDcx?=
 =?utf-8?B?K2d5ZGhFeHR2Z2NCRjlpWXVJNkN0akhKeFpuSXZrcnBUMzA3ME1MMmR6SXdp?=
 =?utf-8?B?bWYzMldrMmFxNFQ3V25BZ1pYaWp6T2lhQ3BheGx6MFhrdWVhcHBBTFVYUW5m?=
 =?utf-8?Q?YVZrPnUoExlv9rpUrF1KzOpaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2956ea-7937-4814-1e6d-08de236a4b43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:40:57.3836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwNLNnUZ4rQe3dbsdBciQeHN/U8chi+9Rgp6s0/DEwAEhrypQZj0qWlc1onZ18k/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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

On 11/13/25 20:07, Timur Kristóf wrote:
> Now that the DC analog connector support and VCE1 support landed,
> SI dGPUs are at feature parity with the old radeon driver.
> 
> Enabling the amdgpu driver by default for SI dGPUs has the
> following benefits:
> 
> - More stable OpenGL support through RadeonSI
> - Vulkan support through RADV
> - Improved performance
> - Better display features through DC
> 
> Users who want to keep using the old driver can do so using:
> amdgpu.si_support=0 radeon.si_support=1
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

The patch should probably also update the text in the Kconfig file drivers/gpu/drm/amd/amdgpu/Kconfig.

That currently reads:

config DRM_AMDGPU_SI
        bool "Enable amdgpu support for SI parts"
        depends on DRM_AMDGPU
        help
          Choose this option if you want to enable experimental support
          for SI (Southern Islands) asics.

          SI is already supported in radeon. Experimental support for SI
          in amdgpu will be disabled by default and is still provided by
          radeon. Use module options to override this:

          radeon.si_support=0 amdgpu.si_support=1

Same for CIK BTW.

Apart from that look good to me,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  drivers/gpu/drm/radeon/radeon_drv.c     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3cf36d28d27f..0539f97fa2f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2327,6 +2327,7 @@ static bool amdgpu_support_enabled(struct device *dev,
>  		param = "si_support";
>  		module_param = amdgpu_si_support;
>  		amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
> +		support_by_default = true;
>  		break;
>  
>  	case CHIP_BONAIRE:
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 40dff6feac8a..fe7ed70f4703 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -273,6 +273,7 @@ static bool radeon_support_enabled(struct device *dev,
>  		gen = "SI";
>  		module_param = radeon_si_support;
>  		amdgpu_support_built &= IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
> +		support_by_default = false;
>  		break;
>  
>  	case CHIP_BONAIRE:

